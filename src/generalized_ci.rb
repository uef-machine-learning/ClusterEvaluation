#!/usr/bin/ruby
def read_pa(pafn)
  pa = File.readlines(pafn).collect { |x| x.strip }
  header_end = -1

  # ignore "VQ PARTITIONING 2.0" header if exists
  (1..10).each { |i| header_end = i if /\----+/.match(pa[i]) }

  # Input file labels start from 1, convert to start from 0
  labels = pa[(header_end + 1)..-1].collect { |x| x.to_i - 1 }
  k = labels.uniq.size
  return [labels, k]
end

def get_orphan_count(paA, kA, paB, kB)
  counts = Array.new(kB, 0)
  n = paA.size

  sizeA = Array.new(kA + 1, 0)
  sizeB = Array.new(kB + 1, 0)

  # Array of size kA * kB
  m = Array.new(kA) { Array.new(kB, 0) }
  jaccard = Array.new(kA) { Array.new(kB, 0) }

  for i in 0..(n - 1)
    x = paA[i]
    y = paB[i]
    sizeA[x] += 1
    sizeB[y] += 1
    # Count number of common points that belong to both clusters x and y
    m[x][y] += 1
  end

  for i in 0..(kA - 1)
    for j in 0..(kB - 1)
      z = m[i][j].to_f #Intersection of clusters i and j
      jaccard[i][j] = z / (sizeA[i] + sizeB[j] - z)
    end
  end

  for i in 0..(kA - 1)
    a = jaccard[i].each_with_index.max[1] #index of largest
    counts[a] += 1 # a is the nearest of cluster i
  end

  # Count orphans, number of cases where count=0
  numzero = counts.inject(0) { |accum, i| x = 0; x = 1 if i == 0; accum + x }

  return numzero
end

if ARGV[0].nil? or !File.exist?(ARGV[0]) or ARGV[1].nil? or !File.exist?(ARGV[1])
  puts "Usage: ./generalized_ci.rb example_data/s4-gt.pa example_data/s4-result.pa"
  exit!
end

(paA, kA) = read_pa(ARGV[0])
(paB, kB) = read_pa(ARGV[1])
exit! if paA.size != paB.size

zeroA = get_orphan_count(paA, kA, paB, kB)
zeroB = get_orphan_count(paB, kB, paA, kA)
puts "orphansA=#{zeroA} orphansB=#{zeroB}"
ci = [zeroA, zeroB].max

puts "CI = #{ci}"
